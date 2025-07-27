import { Routes } from '@angular/router';
import { Ticketviewer } from './ticketviewer/ticketviewer';
import { Knowledgebase } from './knowledgebase/knowledgebase';
import { Livelogs } from './livelogs/livelogs';

export const routes: Routes = [
    { path: '', component: Ticketviewer },
    { path: 'ticketviewer', component: Ticketviewer },
    { path: 'knowledgebase', component: Knowledgebase },
    { path: 'livelogs', component: Livelogs },
];
