import {
  Component,
  OnInit,
  OnDestroy,
  ViewChild,
  ElementRef,
} from '@angular/core';
import { CommonModule } from '@angular/common';

interface LogEntry {
  timestamp: string;
  level: 'INFO' | 'WARN' | 'ERROR';
  message: string;
}

@Component({
  selector: 'app-livelogs',
  imports: [CommonModule],
  templateUrl: './livelogs.html',
  standalone: true,
})
export class Livelogs implements OnInit, OnDestroy {
  @ViewChild('logsContainer') private logsContainer!: ElementRef;

  logs: LogEntry[] = [];
  private logInterval: any;
  private logCounter: number = 0;

  ngOnInit(): void {
    this.logInterval = setInterval(() => {
      this.addLog();
    }, this.getRandomInterval());
  }

  ngOnDestroy(): void {
    if (this.logInterval) {
      clearInterval(this.logInterval);
    }
  }

  private generateLog(): LogEntry {
    const levels: ('INFO' | 'WARN' | 'ERROR')[] = ['INFO', 'WARN', 'ERROR'];
    const randomLevel = levels[Math.floor(Math.random() * levels.length)];
    const now = new Date();
    const timestamp =
      now.toLocaleTimeString('en-US', { hour12: false }) +
      '.' +
      now.getMilliseconds().toString().padStart(3, '0');
    this.logCounter++;

    let message: string;
    switch (randomLevel) {
      case 'INFO':
        message = `User activity detected. Event ID: ${this.logCounter}.`;
        break;
      case 'WARN':
        message = `Low disk space warning on /dev/sda1. Free: ${Math.floor(
          Math.random() * 500
        )}MB.`;
        break;
      case 'ERROR':
        message = `Failed to connect to database. Retrying... (Attempt ${
          Math.floor(Math.random() * 10) + 1
        })`;
        break;
    }

    return { timestamp, level: randomLevel, message };
  }

  private addLog(): void {
    const newLog = this.generateLog();
    this.logs.push(newLog);
    if (this.logs.length > 100) {
      this.logs.shift();
    }
    setTimeout(() => this.scrollToBottom(), 0);
  }

  private scrollToBottom(): void {
    if (this.logsContainer) {
      this.logsContainer.nativeElement.scrollTop =
        this.logsContainer.nativeElement.scrollHeight;
    }
  }

  private getRandomInterval(): number {
    return Math.floor(Math.random() * 2000) + 1000; // 1 to 3 seconds
  }
}
