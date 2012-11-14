
/*
 * GET home page.
 */

exports.index = function(req, res){
  db.projects.find({}, function(err, projects) {
    res.send(projects);
  });
};