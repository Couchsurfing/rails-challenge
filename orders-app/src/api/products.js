import {instance} from './global';

export async function get() {
    return instance.get('/api/products');
}

export async function getVariants(productId) {
    return instance.get(`/api/products/${productId}/variants`);
}

export async function getAllVariants() {
    return instance.get('/api/variants');
}