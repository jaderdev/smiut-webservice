import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ChangePasswordComponent } from './change-password/change-password.component';
import { PersonalInformationComponent } from './personal-information/personal-information.component';
import { UserProfileComponent } from './user-profile.component';

const routes: Routes = [
  {
    path: '',
    component: UserProfileComponent,
    children: [
      {
        path: 'personal-information',
        component: PersonalInformationComponent,
      },
      {
        path: 'change-password',
        component: ChangePasswordComponent
      },
      { path: '', redirectTo: 'personal-information', pathMatch: 'full' },
      { path: '**', redirectTo: 'personal-information', pathMatch: 'full' },
    ],
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class UserProfileRoutingModule { }
