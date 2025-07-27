import { ComponentFixture, TestBed } from '@angular/core/testing';

import { Ticketviewer } from './ticketviewer';

describe('Ticketviewer', () => {
  let component: Ticketviewer;
  let fixture: ComponentFixture<Ticketviewer>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [Ticketviewer]
    })
    .compileComponents();

    fixture = TestBed.createComponent(Ticketviewer);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
