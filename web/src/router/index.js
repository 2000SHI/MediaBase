import { createRouter, createWebHistory } from 'vue-router'
import Login from '@/views/Login.vue'
import Register from '@/views/Register.vue'
import Layout from '@/views/Layout.vue'
import MediaLibrary from '@/views/MediaLibrary.vue'
import Me from '@/views/Me.vue'
import Search from '@/views/Search.vue'
import Media from '@/views/Media.vue'
import Person from '@/views/Person.vue'


const routes = [
    { path: '/login', component: Login },
    { path: '/register', component: Register },
    { 
        path: '/',
        component: Layout,
        redirect: '/media_library',
        children: [
            { path: '/media_library', component: MediaLibrary },
            { path: '/me', component: Me },
            { path: '/search', component: Search },
            { path: '/media_library/:id', component: Media },
            { path: '/person/:id', component: Person }
        ]
    }
]

const router = createRouter({
    history: createWebHistory(),
    routes: routes
})

export default router;