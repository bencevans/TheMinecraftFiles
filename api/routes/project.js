module.exports = function (req, res, next) {
  tmf.getProject(req.params.project, function (err, project) {
    if(err) return next(err);
    if(!project) {
      res.status(404);
      return res.send({message:'Project Not Found'});
    }
    project.getImage(function (err) {
      project.getCreator(function (err) {
        if(err) return next(err);
        return res.send(project);
      });
    });
  });
};