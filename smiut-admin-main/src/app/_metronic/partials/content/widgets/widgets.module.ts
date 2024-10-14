import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { InlineSVGModule } from 'ng-inline-svg-2';
// Advanced Tables
// Tiles
// Other
import { DropdownMenusModule } from '../dropdown-menus/dropdown-menus.module';
import { NgbDropdownModule } from '@ng-bootstrap/ng-bootstrap';

@NgModule({
  declarations: [
    // Advanced Tables

  ],
  imports: [
    CommonModule,
    DropdownMenusModule,
    InlineSVGModule,
    NgbDropdownModule,
  ],
  exports: [
    // Advanced Tables

  ],
})
export class WidgetsModule { }
