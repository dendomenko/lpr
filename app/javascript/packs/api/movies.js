import Vue from "vue/dist/vue.esm";
import store from "../store/store";

const toMovie = (item, full) => {
  const movie = {
    id: item.id,
    title: item.title,
    description: item.description,
    year: item.year,
    rating: item.rating
  };
  if (full) {
    movie.actors = item.actors;
    movie.directors = item.directors;
    movie.comments = item.comments;
  }
  return movie;
};

export const index = () =>
  new Promise((resolve, reject) => {
    Vue.http
      .get("movies/")
      .then(response => {
        const data = response.data;
        const movies = [];
        data.forEach(item => {
          movies.push(toMovie(item, false));
        });
        return resolve({movies});
      })
      .catch(error => reject(error));
  });

export const getMovie = id =>
  new Promise((resolve, reject) => {
    Vue.http
      .get(`movies/${id}`)
      .then(response => {
        const data = response.data;
        const movie = toMovie(data, true);
        return resolve(movie);
      })
      .catch(error => reject(error));
  });

export const rateMovie = (id, rating) =>
  new Promise((resolve, reject) => {
    Vue.http
      .post(`movies/${id}/rate`, {
          rating: rating
        },
        {
          headers: {
            Authorization: `Bearer: ${store.getters["authentication/authToken"]}`
          }
        })
      .then(response => {
        const movie = toMovie(response.data, true);
        return resolve(movie);
      })
      .catch(error => reject(error));
  });

export const deleteVote = id =>
  new Promise((resolve, reject) => {
    Vue.http
      .delete(`movies/${id}/unvote`, {
        headers: {
          Authorization: `Bearer: ${store.getters["authentication/authToken"]}`
        }
      })
      .then(response => {
        const movie = toMovie(response.data, true);
        return resolve(movie);
      })
      .catch(error => {
        console.log(error);
        return reject(error);
      });
  });
