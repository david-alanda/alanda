import { Injectable, Type } from "@angular/core";
import { Component } from "@angular/compiler/src/core";
import { VacationProjectDetailsComponent } from "../components/forms/projects/vacation/vacation-project-details.component";

@Injectable()
export class ProjectDetailsServiceNg {

  private propertyComponents: Map<string, Type<any>>

  constructor() {
    this.propertyComponents = new Map<string, Type<any>>();
    this.propertyComponents.set('VACATION', VacationProjectDetailsComponent);
  }

  getPropsForType(key : string): Type<Component> {
    return this.propertyComponents.get(key);
  }
}