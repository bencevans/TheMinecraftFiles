module.exports = function (req, res, next) {
  tmf.getProject(req.params.project, function (err, project) {
    if(err) return next(err);
    project.getImage(function (err) {
      project.getCreator(function (err) {
        if(err) return next(err);
        if(project) return res.send(project);
        res.status(404);
        res.send({message:'Project Not Found'});
      });
    });
  });
};