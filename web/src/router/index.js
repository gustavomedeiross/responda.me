import {createRouter, createWebHistory} from 'vue-router'
/* import Home from "@/views/Home.vue"; */
import About from "@/views/About.vue";
import Login from "@/views/Login";
import Register from "@/views/Register";
import Quizzes from "@/views/quiz/Quizzes";
import CreateQuiz from "@/views/quiz/Quizzes";
import EditQuiz from "@/views/quiz/EditQuiz";

const routes = [
    {
        path: '/',
        name: 'home',
        component: Login
    },
    {
        path: '/login',
        name: 'login',
        component: Login
    },
    {
        path: '/register',
        name: 'register',
        component: Register
    },
    {
        path: '/quizzes',
        name: 'quizzes',
        component: Quizzes,
        children: [
            {
                path: '/quizzes/create',
                name: 'create',
                component: CreateQuiz
            }
        ]
    },
    {
        path: '/quizzes/:id',
        name: 'edit',
        component: EditQuiz
    },
    {
        path: '/about',
        name: 'about',
        component: About
    }
]

const router = createRouter({
    history: createWebHistory(process.env.BASE_URL),
    routes,
    linkActiveClass: 'active'
})

export default router
