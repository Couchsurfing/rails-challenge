import {instance} from './global';

export function all() {
    return instance.get('/api/orders');
}

export function update(orderId, status) {
    return instance.patch(`/api/orders/${orderId}`, {
        status
    });
}
