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
    '# Welcome to the Knowledgebase Editor\n\nThis is a **simple** editor with a *preview* mode.\n\n## Features:\n- Markdown support (basic rendering)\n- Toggle preview\n- Save functionality (console log only)';
  previewMode: boolean = false;

  togglePreview(): void {
    this.previewMode = !this.previewMode;
  }

  saveContent(): void {
    console.log('Saving content:', this.editorContent);
    alert('Content saved (check console for output)!');
  }
}
