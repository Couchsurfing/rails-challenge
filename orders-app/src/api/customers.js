import {instance} from './global';

export async function get() {
    return instance.get('/api/customers');
}