import { Injectable } from '@angular/core';
import { ApiAxiosService } from '../api-axios/api-axios.service';
import { FunctionsService } from '../functions/functions.service';
import { HttpService } from '../http-service/http.service';

@Injectable({
  providedIn: 'root'
})
export class SensorsService {
  constructor(
    private apiAxios: ApiAxiosService,
    private functionsService: FunctionsService,
    private httpService: HttpService
  ) { }

  private endpoint: string = "sensores-data";
  private _item: any = [];

  public get item(): any {
    return this._item;
  }
  public set item(value: any) {
    this._item = value;
  }

  private _sensors: any = [];

  public get sensors(): any[] {
    return this._sensors;
  }
  public set sensors(value: any[]) {
    this._sensors = value;
  }


  private qtdMobile: number = 3;
  private qtdDesktop: number = 6;

  public gaugeOptions: any = {
    type: "semi",
    umid: "%",
    temp: "°C",
    thick: 6,
    cap: "round",
    size: {
      mobile: 110,
      desktop: 120
    },
  }

  getItemBySlug(id: any) {
    const url = `empresas/${id}/sensores`;
    return this.httpService.get<any>(url);

    //const response = this.apiAxios.read(url);
    //return response;
  }

  async getLastValuesByDeviceId(deviceid: any, limit: number = 10) {
    const url = `sensores/data/${deviceid}`;
    return this.httpService.get<any>(url);

    //const response = await this.apiAxios.read(url);
    //return response;
  }

  async getLastValuesByDeviceIdBkp(deviceid: any, limit: number = 10) {
    const url = `sensores/data/${deviceid}`;
    const response = await this.apiAxios.read(url);
    return response;
  }

  setItem(data: any) {
    this.item = this.verifyInitData(data);
  }
  eraseData() {
    this.item = undefined;
  }

  verifyInitData(data: any) {
    if (data?.mobile && data?.desktop) return data;
    if (data == undefined) return {};
    return this.splitSensors(data);
  }

  splitSensors(data: any) {
    return {
      mobile: this.functionsService.splitArray(data, this.qtdMobile),
      desktop: this.functionsService.splitArray(data, this.qtdDesktop),
      all: data
    }
  }

  verifyRange(value: any) {
    const temp = parseFloat(value?.atual_temp);
    const umid = parseFloat(value?.atual_umid);
    const tempInRange = (temp <= value?.temp_menor_igual && temp >= value?.temp_maior_igual);
    const umidInRange = (umid <= value?.umid_menor_igual && umid >= value?.umid_maior_igual);

    let aux = {
      inRange: tempInRange && umidInRange,
      temperatura: tempInRange,
      umidade: umidInRange
    }
    return aux;
  }

  formatSensors(sensors: any) {
    const sensorAux = sensors.filter((sensor: any) => sensor.ativo == 1);
    sensorAux.map((sensor: any) => {
      if (typeof (sensor.range) == 'string') {
        sensor.range = JSON.parse(sensor.range)
      }
    });
    return this.splitSensors(sensorAux);
  }

  getAllByEmpresa(id: number, ativo: any = "") {
    const url = `empresas/${id}/sensores`;
    const response = this.apiAxios.read(url, { ativo: ativo });
    return response;
  }

  verifyOutRangeSendMessage(sensorsOld: any, sensorsNew: any) {
    if (!sensorsOld) return;
    let sensorsOut: any = [];
    sensorsOld.forEach((sensorOld: any) => {
      const sensor = sensorsNew.filter((sensor: any) => sensor.id == sensorOld.id)[0];
      if (sensor?.range?.inRange == false && sensorOld?.range?.inRange == true) {
        sensorsOut.push(sensor.nome);
      }
    });
    return sensorsOut;
  }

}
