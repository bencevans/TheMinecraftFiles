module.exports = function (req, res, next) {
  console.log(tmf)
  console.log(req.params)
  tmf.getProject('tronic', function (err, project) {
    if(err) return next(err);
    console.log(err, project)
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