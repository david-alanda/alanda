import { Injectable, Inject } from "@angular/core";
import { AppSettings, APP_CONFIG } from "../../models/AppSettings";
import { HttpClient } from "@angular/common/http";
import { Observable } from "rxjs";
import { ExceptionHandlingService } from "../exceptionHandling.service";
import { catchError } from "rxjs/operators";


@Injectable({
  providedIn: 'root'
})
export class HistoryServiceNg extends ExceptionHandlingService{

    private endpointUrl : string;

    constructor(private http: HttpClient,
        @Inject(APP_CONFIG) config: AppSettings) {
        super();
        this.endpointUrl = config.API_ENDPOINT + "/history";
    }

    search(filterOptions, pageNumber, pageSize): Observable<any[]> {
        let searchDto = {};
        for(let key in filterOptions) {
            if(filterOptions[key] != '') {
                searchDto[key] = encodeURIComponent(filterOptions[key]);
            }
        }
        return this.http.post<any[]>(`${this.endpointUrl}/search/${pageNumber}/${pageSize}`, searchDto).pipe(catchError(this.handleError('search', [])));
    }

}