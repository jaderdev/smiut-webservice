import { Injectable } from '@angular/core';
import { ApiService } from '../base/api/api.service';
import { MessagesService } from '../base/messages/messages.service';

@Injectable({
  providedIn: 'root'
})
export class EwelinkService {
  private endpoint: string = "devices";

  constructor(
    private api: ApiService,
    private messages: MessagesService
  ) { }

  async getTempUmidValue(deviceid: string) {
    let data = {
      currentHumidity: 0,
      currentTemperature: 0,
      online: 0,
    }
    const response = (await this.api.read(`${this.endpoint}/${deviceid}`)).data;
    if (response.error) {
      this.messages.toastError(response.message);
      console.log(response.message);
      return;
    }
    const dataResponse = response.data;

    data.currentHumidity = dataResponse.humidity == "unavailable" ? 0 : dataResponse.humidity;
    data.currentTemperature = dataResponse.temperature == "unavailable" ? 0 : dataResponse.temperature;
    data.online = dataResponse.online;

    return data;
  }


}
