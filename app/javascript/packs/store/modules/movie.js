import api from "../../api";

const state = {
  loading: false,
  item: {},
  rating: 0,
  vote: null,
  isVoted: false
};

const getters = {
  loading(state) {
    return state.loading;
  },
  item(state) {
    return state.item;
  },
  rating(state) {
    return state.rating;
  },
  vote(state) {
    return state.vote;
  },
  isVoted(state) {
    return state.isVoted;
  }
};

const mutations = {
  SET_LOADING(state, loading) {
    state.loading = loading;
  },
  SET_MOVIE(state, {data, userId}) {
    state.item = data;
    if (data.rating.length) {
      state.rating =
        data.rating.reduce((prev, curr) => prev + parseFloat(curr.rating), 0) /
        data.rating.length;
    } else {
      state.rating = 0;
    }
    if (userId) {
      const vote = data.rating.filter(vote => vote.user_id === userId);
      state.isVoted = !!vote.length;
      state.vote = null;
      if (vote.length) {
        state.vote = vote[0].rating;
      }
    }
  },
  APPEND_COMMENT(state, comment) {
    state.item.comments.push(comment);
  },
  SET_VOTED(state, value) {
    state.isVoted = value;
  },
  SET_VOTE(state, value) {
    state.vote = value;
  }
};

const actions = {
  loadMovie({ commit }, { id, userId = null }) {
    commit("SET_LOADING", true);
    return api.movies
      .getMovie(id)
      .then(data => {
        commit("SET_MOVIE", { data, userId });
      })
      .catch(() => {
        commit("SET_MOVIE", {});
      })
      .finally(() => {
        commit("SET_LOADING", false);
      });
  },
  rateMovie({ commit }, { id, rating, userId = null }) {
    return api.movies
      .rateMovie(id, rating)
      .then(data => {
        commit("SET_MOVIE", { data, userId });
        commit("SET_VOTE", rating);
        commit("SET_VOTED", true);
      })
      .catch(error => {
        commit("error/SET_ERROR", error.body.error, { root: true });
      });
  },
  // setVoted({ commit }, value) {
  //   commit("SET_VOTED", value);
  // },
  // setVote({ commit }, value) {
  //   commit("SET_VOTE", value);
  // }
  unvoteMovie({ commit }, { id, userId = null }) {
    return api.movies
      .deleteVote(id)
      .then(data => {
        commit("SET_MOVIE", { data, userId });
        commit("SET_VOTE", null);
        commit("SET_VOTED", false);
      })
      .catch(error => {
        commit("error/SET_ERROR", error.body.error, { root: true });
      });
  }
};

export default {
  namespaced: true,
  state,
  mutations,
  getters,
  actions
};
