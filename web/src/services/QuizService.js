import axios from "axios";

const baseUrl = 'http://localhost:4001/api';

const quizService = {

    createQuiz(quiz) {

        axios.post(baseUrl + '/quizzes', {
            quiz: quiz
        }).then((res) => {
            console.log(res)
        });
    }

};

export default quizService;
