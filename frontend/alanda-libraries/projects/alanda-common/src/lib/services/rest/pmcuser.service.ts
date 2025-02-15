import { Injectable, Inject } from "@angular/core";
import { AppSettings, APP_CONFIG } from "../../models/AppSettings";
import { HttpClient } from "@angular/common/http";
import { Observable, of, BehaviorSubject } from "rxjs";
import { PmcUser } from "../../models/PmcUser";
import { ListResult } from "../../models/ListResult";
import { PmcGroup } from "../../models/PmcGroup";
import { PmcPermission } from "../../models/PmcPermission";
import { PmcRole } from "../../models/PmcRole";
import { tap, catchError } from 'rxjs/operators';
import { ExceptionHandlingService } from "../exceptionHandling.service";


@Injectable({
  providedIn: 'root'
})
export class PmcUserServiceNg extends ExceptionHandlingService{

  private endpointUrl : string;
  public user$: BehaviorSubject<PmcUser> = new BehaviorSubject(null); 


  constructor(private http: HttpClient,
    @Inject(APP_CONFIG) config: AppSettings) {
    super();
    this.endpointUrl = config.API_ENDPOINT + "/user";
    console.log("PmcUserServiceNg from pmc-common");
  }

  getUsers(serverOptions: any): Observable<ListResult<PmcUser>> {
    return this.http.post<ListResult<PmcUser>>(`${this.endpointUrl}/repo`, serverOptions).pipe(catchError(this.handleError('getUsers')));
  }

  getUser(guid: number): Observable<PmcUser> {
    return this.http.get<PmcUser>(`${this.endpointUrl}/repo/${guid}`).pipe(catchError(this.handleError('getUser')));
  }

  getUserByLogin(login: string): Observable<PmcUser> {
    return this.http.get<PmcUser>(`${this.endpointUrl}/single/${login}`).pipe(catchError(this.handleError('getUserByLogin')));
  }

  updateUser(user: PmcUser): Observable<any> {
    return this.http.put<any>(`${this.endpointUrl}/repo/update`, user).pipe(catchError(this.handleError('updateUser')));
  }

  save(user: PmcUser): Observable<any> {
    return this.http.post<PmcUser>(`${this.endpointUrl}/repo/create`, user).pipe(catchError(this.handleError('save')));
  }

  getEffectiveRolesForUser(userGuid: number): Observable<any[]> {
    return this.http.get<any[]>(`${this.endpointUrl}/roles/effective/${userGuid}`).pipe(catchError(this.handleError('getEffectiveRolesForUser')));
  }

  updateRolesForUser(userGuid: number, roles: PmcRole[]): Observable<any> {
    return this.http.put<any>(`${this.endpointUrl}/roles/update/${userGuid}`, roles).pipe(catchError(this.handleError('updateRolesForUser')));
  }

  getGroupsForUser(login: string): Observable<PmcGroup[]> {
    return this.http.get<PmcGroup[]>(`${this.endpointUrl}/groups/${login}`).pipe(catchError(this.handleError('getGroupsForUser')));
  }

  getEffectivePermissionsForUser(userGuid: number): Observable<any[]> {
    return this.http.get<any[]>(`${this.endpointUrl}/permissions/effective/${userGuid}`).pipe(catchError(this.handleError('getEffectivePermissionsForUser')));
  }

  updatePermissionsForUser(userGuid: number, permissions: PmcPermission[]): Observable<any> {
    return this.http.put<any>(`${this.endpointUrl}/permissions/update/${userGuid}`, permissions).pipe(catchError(this.handleError('updatePermissionsForUser')));
  }

  getCurrentUser(): Observable<PmcUser> {
    return this.http.get<PmcUser>(`${this.endpointUrl}/current`).pipe(
      catchError(this.handleError('getCurrentUser')),
      tap((user) => {
        this.user$.next(user);
      })
    );
  }

/*   updateCurrentUser(): void {
    console.log("updateCurrentUser");
    this.getCurrentUser().subscribe(
      (res) => {
        console.log("updateCurrentUser res", res);
        this.currentUser.next(res);
      },
      (err) => {
        console.log("updateCurrentUser err", err);
        this.currentUser.next(null);
      }
    );
  } */

  runAsUser(userName: string): Observable<PmcUser> {
    return this.http.post<PmcUser>(`${this.endpointUrl}/runas/${userName}`,{}).pipe(
        catchError(this.handleError('runAsUser')),
        tap((user) => {
          this.user$.next(user);
        })
    );
  }

  releaseRunAs(): Observable<PmcUser> {
    return this.http.post<PmcUser>(`${this.endpointUrl}/release`,{}).pipe(
        catchError(this.handleError('releaseRunAs')),
        tap((user) => {
          this.user$.next(user);
        })
    );
  }

  getUsersByGroupId(groupId: number): Observable<PmcUser[]> {
    return this.http.get<PmcUser[]>(`${this.endpointUrl}/repo/getUsersByGroupId/${groupId}`).pipe(catchError(this.handleError('runAsUser')));
  }

}