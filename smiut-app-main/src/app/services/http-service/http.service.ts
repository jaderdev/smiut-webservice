import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders, HttpErrorResponse, HttpInterceptor, HttpRequest, HttpHandler, HttpEvent } from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})

export class HttpService {
  private baseUrl = environment.apiURL; // Substitua pelo URL da sua API

  constructor(private http: HttpClient) { }

  intercept(req: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
    const existToken = this.isTokenSetted();
    const token = existToken.isSetted ? existToken.token : "";

    // Clonar a requisição e adicionar o header Authorization com o token
    const authReq = req.clone({
      headers: req.headers.set('Authorization', `Bearer ${token}`)
    });

    return next.handle(authReq).pipe(
      catchError((error: HttpErrorResponse) => {
        // Tratar erros aqui se necessário
        return throwError(error);
      })
    );
  }

  isTokenSetted() {
    if (sessionStorage.token) {
      return {
        isSetted: true,
        token: sessionStorage.getItem('token'),
      };
    }
    return {
      isSetted: false,
      token: '',
    };
  }

  // Método para enviar requisições GET
  get<T>(url: string): Observable<T> {
    const apiUrl = `${this.baseUrl}/${url}`;
    return this.http.get<T>(apiUrl);
  }

  // Método para enviar requisições POST
  post<T>(url: string, body: any): Observable<T> {
    const apiUrl = `${this.baseUrl}/${url}`;
    return this.http.post<T>(apiUrl, body);
  }
}
