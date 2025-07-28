import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-knowledgebase',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './knowledgebase.html',
  styleUrl: './knowledgebase.css',
})
export class Knowledgebase {
  editorContent: string =
    '# Welcome to the Knowledgebase Editor';
  previewMode: boolean = false;

  togglePreview(): void {
    this.previewMode = !this.previewMode;
  }

  saveContent(): void {
    console.log('Saving content:', this.editorContent);
    alert('Content saved (check console for output)!');
  }
}
