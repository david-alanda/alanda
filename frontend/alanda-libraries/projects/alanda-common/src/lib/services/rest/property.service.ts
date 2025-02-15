import { ExceptionHandlingService } from "../exceptionHandling.service";
import { Injectable, Inject } from "@angular/core";
import { APP_CONFIG, AppSettings } from "../../models/AppSettings";
import { HttpClient } from "@angular/common/http";
import { Observable } from "rxjs";
import { catchError } from "rxjs/operators";

@Injectable({
    providedIn: 'root'
  })
  export class PropertyService extends ExceptionHandlingService{ 

    endpointUrl: string;

    constructor(private http: HttpClient,
        @Inject(APP_CONFIG) config: AppSettings) {
        super();
        this.endpointUrl = config.API_ENDPOINT + "/pmc-property";
      }

    setDate(entityId, entityType, projectGuid, key, value): Observable<any> {
        return this.set(entityId, entityType, projectGuid, key, value, 'DATE');
    }

    setString(entityId, entityType, projectGuid, key, value): Observable<any> {
        return this.set(entityId, entityType, projectGuid, key, value, 'STRING');
    }

    /* setGroupRole(projectGuid, key, value): Observable<any> {
        return this.set(null, null, projectGuid, 'role_group_' + key, value, 'STRING');
    }

    setUserRole(projectGuid, key, value): Observable<any> {
        return this.set(null, null, projectGuid, 'role_user_' + key, value, 'STRING');
    }

    getUserRole(projectGuid, key): Observable<any> {
        key = 'role_user_' +  key;
        return this.http.get<any>(`${this.endpointUrl}/get?pmc-project-guid=${projectGuid}&key=${key}'`).pipe(catchError(this.handleError('getUserRole')));
    }

    getGroupRole(projectGuid, key): Observable<any> {
        key = 'role_group_' +  key;
        return this.http.get<any>(`${this.endpointUrl}/get?pmc-project-guid=${projectGuid}&key=${key}'`).pipe(catchError(this.handleError('getGroupRole')));
    } */

    set(entityId, entityType, projectGuid, key, value, valueType): Observable<any>{
        let obj = {
            entityId: entityId,
            entityType: entityType,
            pmcProjectGuid: projectGuid,
            key: key,
            value: value,
            valueType: valueType
        }
        return this.http.post<any>(`${this.endpointUrl}/set`, obj).pipe(catchError(this.handleError('setProperty')));
    }

    get(entityId, entityType, projectGuid, key): Observable<any> {
        let urlString = '/get?';
        if(entityId) {
            urlString += 'entity-id=' + entityId + '&';
        }
        if(entityType) {
            urlString += 'entity-type=' + entityType + '&';
        }
        if(projectGuid) {
            urlString += 'pmc-project-guid=' + projectGuid + '&'; 
        }
        urlString += 'key=' + key;
        return this.http.get<any>(`${this.endpointUrl}${urlString}`).pipe(catchError(this.handleError('getProperty')));
    }
}