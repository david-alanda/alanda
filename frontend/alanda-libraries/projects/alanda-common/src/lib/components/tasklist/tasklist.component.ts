import { Component, OnInit, Input, ViewChild } from '@angular/core';
import { TableAPIServiceNg } from '../../services/tableAPI.service';
import { LazyLoadEvent, MenuItem, MessageService } from 'primeng/api';
import { ServerOptions } from '../../models/serverOptions.model';
import { TaskServiceNg } from '../../services/rest/task.service';
import { Table } from 'primeng/table';
import { PmcUserServiceNg } from '../../services/rest/pmcuser.service';
import { PmcUser } from '../../models/PmcUser';

@Component({
  selector: 'tasklist-component',
  templateUrl: './tasklist.component.html' ,
  styles: []
})
export class TasklistComponent implements OnInit {

  tasksData: any = {};
  layouts: any[] = [];
  validLayouts: any[] = [];
  selectedLayout: any = {};
  selectedTask: any = {};
  selectedColumns: any = [];
  loading: boolean = true;
  groupTasks: boolean = false;
  currentUser: PmcUser;
  serverOptions: ServerOptions;
  menuItems: MenuItem[];
  delegationItems: MenuItem[];
  showDelegateDialog: boolean = false;
  candidateUsers: any[] = [];
  delegatedTaskData: any;

  @ViewChild('tt') turboTable: Table;
 
  constructor(private taskService: TaskServiceNg, private tableAPIServiceNg: TableAPIServiceNg, private pmcUserService: PmcUserServiceNg,
              public messageService: MessageService) {
    this.serverOptions = {
      pageNumber: 1,
      pageSize: 15,
      filterOptions: {hideSnoozedTasks: 1, mytasks: 1},
      sortOptions: {},
    };

    this.menuItems = [
      {label: 'Download CSV', icon: 'pi pi-fw pi-download', command: (onclick) => this.turboTable.exportCSV()},
      {label: 'Reset all filters', icon: 'pi pi-fw pi-times', command: (onclick) => this.turboTable.reset()},
    ];
  };

  ngOnInit() { 
    this.loading = true;
    this.pmcUserService.getCurrentUser().subscribe(
      user => {
        this.currentUser = user;
        this.validLayouts = this.tableAPIServiceNg.getTaskListLayouts(user);
        if(this.currentUser.groups.indexOf('srvreq') !== -1){ 
          this.validLayouts = this.layouts.filter(l => l.name !== 'default');
          this.selectedLayout = this.validLayouts[0];
        } else {
          this.selectedLayout = this.validLayouts.filter(layout => layout.name === 'default')[0];
        }
        this.validLayouts.sort((a, b) => a.displayName.localeCompare(b.displayName));
      },
      error => {
        this.messageService.add({severity:'error', summary:'Get Current User', detail: error.message});
        this.loading = false;
      }
    );
  }

  loadTasks(serverOptions: ServerOptions){
    this.loading = true;
    this.taskService.loadTasks(serverOptions).subscribe(
      res => {
        this.tasksData = res;
        for(let task of this.tasksData.results){
          task['claimLabel'] = "Claim";
          if(this.currentUser.guid === +task.task.assignee_id){
            task['claimLabel'] = "Unclaim";
          }
        }
        this.loading = false;
      },
      error => {
        this.messageService.add({severity:'error', summary:'Load Tasks', detail: error.message}); 
        this.loading = false;
      });
  }

  loadTasksLazy(event: LazyLoadEvent){
    this.serverOptions = this.getNewServerOptions();
    if(event.sortField){
      let sortOptions = {}
      const dir = event.sortOrder == 1 ? "asc" : "desc";
      sortOptions[event.sortField] = {dir: dir, prio: 0}
      this.serverOptions.sortOptions = sortOptions;
    }
    
    Object.keys(event.filters).forEach((key) => {
      this.serverOptions.filterOptions[key] = event.filters[key].value;
    })

    this.serverOptions.pageNumber = event.first / this.serverOptions.pageSize + 1;
    this.loadTasks(this.serverOptions);
  }; 

  onChangeLayout(){
    this.serverOptions.pageNumber = 1;
    const key = "project.additionalInfo.rootparent.projectTypeIdName";
    this.serverOptions.filterOptions = {hideSnoozedTasks: 1};
    if(!this.groupTasks){
      this.serverOptions.filterOptions['mytasks'] = 1;
    }
    if(this.selectedLayout.filterOptions){
      delete this.serverOptions.filterOptions[key];
      this.serverOptions.filterOptions[key] = this.selectedLayout.filterOptions[key];
    }else {
      delete this.serverOptions.filterOptions[key];
    }  
    this.loadTasks(this.serverOptions);
  }

  toggleGroupTasks(v: boolean){
    this.groupTasks = v;
    delete this.serverOptions.filterOptions.mytasks;
    if(!this.groupTasks){
      this.serverOptions.filterOptions['mytasks'] = 1;
    }
    this.loadTasks(this.serverOptions);
  }

  getCondition(obj, condition) {
    if(condition === undefined) return '';
    const props = Object.keys(obj).reduce( (acc, next) => `${acc} , ${next}`);
    const evalCon = new Function(` return function ({${props}})  { return ${condition}} `);
    return evalCon()(obj)
  }

  claimAction(task){
    this.loading = true;
    if(this.currentUser.guid === +task.task.assignee_id){
      this.taskService.unclaim(task.task.task_id).subscribe(
        res => {
          this.loading = false;
          if(this.groupTasks){
            task.task.assignee_id = 0;
            task.task.assignee = "";
            task.claimLabel = "Claim";
          } else{
            this.tasksData.results.splice(this.tasksData.results.indexOf(task),1);
          }
          this.messageService.add({severity:'success', summary:'Unclaim Task', detail: 'Task has been unclaimed'});
        },
        error => {this.loading = false; this.messageService.add({severity:'error', summary:'Unclaim Task' , detail: error.message})});
    }
    else{
      this.taskService.assign(task.task.task_id, this.currentUser.guid).subscribe(
        res => {
          this.loading = false;
          task.task.assignee_id = String(this.currentUser.guid);
          task.task.assignee = this.currentUser.firstName + ' ' + this.currentUser.surname;
          task.claimLabel = "Unclaim";
          this.messageService.add({severity:'success', summary:'Claim Task', detail: 'Task has been claimed'});
        },
        error => {this.loading = false; this.messageService.add({severity:'error', summary:'Claim Task', detail: error.message})});
    }
  }


  getNewServerOptions(): ServerOptions {
    let serverOptions: ServerOptions = {pageNumber: 1, pageSize: 15, filterOptions: {hideSnoozedTasks: 1}, sortOptions: {}};
    if(this.selectedLayout.filterOptions){
      for(let key of Object.keys(this.selectedLayout.filterOptions)){
        serverOptions.filterOptions[key] = this.selectedLayout.filterOptions[key];
      }
    }
    if(!this.groupTasks){
      serverOptions.filterOptions['mytasks'] = 1;
    }
    return serverOptions;
  }

  openDelegationForm(data){
    this.delegatedTaskData = data;
    this.taskService.getCandidates(data.task.task_id).subscribe(
      (res) => {
        this.candidateUsers = res;
        this.showDelegateDialog = true;
      }
    );
  }

  delegateTask(selectedUser){
    if(selectedUser){
      this.loading = true;
      this.taskService.assign(this.delegatedTaskData.task.task_id,selectedUser.guid).subscribe(
        res => {
          this.loading = false;
          if(this.groupTasks || selectedUser.guid == String(this.currentUser.guid)){
            this.delegatedTaskData.task.assignee_id = +selectedUser.guid;
            this.delegatedTaskData.task.assignee = selectedUser.displayName;
          } else{
            this.tasksData.results.splice(this.tasksData.results.indexOf(this.delegatedTaskData),1);
          }
          this.hideDelegateDialog();
        },
        err => {this.loading = false;this.hideDelegateDialog()}
      )
    }
  }

  hideDelegateDialog(){
    this.delegatedTaskData = {};
    this.showDelegateDialog = false;
  }

  encodeURIAndReplace(v): string {
    return encodeURIComponent(v).replace(/%/g,'~');
  }

  openTask(formKey: string, taskId: string) {
    return '/forms/' + encodeURIComponent(formKey) + '/' + taskId;
  }
}