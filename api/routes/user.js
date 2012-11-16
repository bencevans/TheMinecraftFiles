var user = function (req, res, next) {
  tmf.getUser(req.params.user, function (err, user) {
    if(err) return next(err);
    if(user) return res.send(user);
    res.status(404);
    res.send({message: 'User Not Found'});
  });
};

user.projects = function (req, res, next) {
  tmf.getUser(req.params.user, function (err, user) {
    if(err) return next(err);
    user.getProjects(function (err) {
      if(err) return next(err);
      res.send(user.projects);
    });
  });
};

module.exports = user;