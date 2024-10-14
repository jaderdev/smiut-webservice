import { Injectable } from '@angular/core';
import { ApiService } from '../base/api/api.service';
import { FunctionsService } from '../base/functions/functions.service';

@Injectable({
  providedIn: 'root'
})
export class SensoresService {

  private endpoint: string = "sensores";

  constructor(
    private api: ApiService,
    private fn: FunctionsService
  ) { }

  public gaugeOptions = {
    type: 'semi',
    umid: '%',
    temp: '°C',
    thick: 6,
    cap: 'round',
    size: '120',
  }

  getAllByEmpresa(id: number, ativo: any = "") {
    const response = this.api.read(`empresas/${id}/sensores`, { ativo: ativo });
    return response;
  }

  async getAll() {
    let response = await this.api.read(this.endpoint);
    return response;
  }

  async getItem(id: number) {
    let response = await this.api.readId(this.endpoint, id);
    if (!response) {
      this.fn.redirectNoData();
      return;
    }
    return response;
  }

  async updateSensorValues(deviceid: string) {
    const responseUpdate: any = await this.api.update(`sensores/socket/${deviceid}`, { switch: 'off'});
    return responseUpdate;
  }

  async changeDeviceId(deviceid: string, newDeviceId: string) {
    const response: any = await this.api.post(`devices/${deviceid}/changeTo/${newDeviceId}`, {});
    return response;
  }

  async getLastValuesByDeviceId(deviceid: any, limit: number = 10) {
    const response = await this.api.read(`sensores/data/${deviceid}`);
    return response;
  }

  async create(data: any) {
    const response = await this.api.create(this.endpoint, data);
    return response;
  }

  async update(id: number, data: any) {
    const response = await this.api.update(`sensores/${id}`, data);
    return response;
  }

  async delete(id: any) {
    const response = await this.api.delete(`${this.endpoint}/${id}`);
    return response;
  }

  async deleteFirebase(id: any) {
    const response = await this.api.delete(`${this.endpoint}/${id}/firebase`);
    return response;
  }

  async verify(id: any) {
    const response = await this.api.post(`exists/sensores`, id);
    return response;
  }

  async updateAll(forceAll = false) {
    let url = `${this.endpoint}/updateAll`;
    url = forceAll ? url + "/force" : url;
    const response = await this.api.read(url);
    return response;
  }
}