import { Injectable } from '@angular/core';
import { initializeApp } from "firebase/app"
import { getDatabase, ref } from 'firebase/database';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class FirebaseService {
  database: any;
  constructor() {
    const app = initializeApp(environment.firebaseConfig);
    this.database = getDatabase(app);
  }
  getRef(link: string = '/') {
    return ref(this.database, link);
  }
}
