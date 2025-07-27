import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-ticketviewer',
  imports: [CommonModule],
  templateUrl: './ticketviewer.html',
  standalone: true,
})
export class Ticketviewer {
  data = [
    {
      id: 1,
      subject: 'Website Redesign',
      status: 'Open',
      createdAt: '2024-07-01',
    },
    {
      id: 2,
      subject: 'Bug Fixes for Login',
      status: 'In Progress',
      createdAt: '2024-06-15',
    },
    {
      id: 3,
      subject: 'New Feature: User Profiles',
      status: 'Closed',
      createdAt: '2024-07-20',
    },
    {
      id: 4,
      subject: 'Database Migration',
      status: 'Open',
      createdAt: '2024-07-05',
    },
    {
      id: 5,
      subject: 'Performance Optimization',
      status: 'In Progress',
      createdAt: '2024-06-25',
    },
    {
      id: 6,
      subject: 'API Documentation Update',
      status: 'Closed',
      createdAt: '2024-07-10',
    },
  ];

  selectedStatus: string = 'All';

  get filteredData(): any[] {
    if (this.selectedStatus === 'All') {
      return this.data;
    }
    return this.data.filter((item) => item.status === this.selectedStatus);
  }

  setFilter(status: string): void {
    this.selectedStatus = status;
  }
}
