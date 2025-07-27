import { ComponentFixture, TestBed } from '@angular/core/testing';

import { Livelogs } from './livelogs';

describe('Livelogs', () => {
  let component: Livelogs;
  let fixture: ComponentFixture<Livelogs>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [Livelogs]
    })
    .compileComponents();

    fixture = TestBed.createComponent(Livelogs);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
