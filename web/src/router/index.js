import {createRouter, createWebHistory} from 'vue-router'
import Home from "@/views/Home.vue";
import About from "@/views/About.vue";
import Login from "@/views/Login";
import Quizzes from "@/views/Quizzes";

const routes = [
    {
        path: '/',
        name: 'Home',
        component: Home
    },
    {
        path: '/login',
        name: 'Login',
        component: Login
    },
    {
        path: '/quizzes',
        name: 'Quizzes',
        component: Quizzes
    },
    {
        path: '/about',
        name: 'About',
        component: About
    }
]

const router = createRouter({
    history: createWebHistory(process.env.BASE_URL),
    routes
})

export default router
