let project = new Project('Kha Shadows');

project.addAssets('Assets/**');

project.addShaders('Shaders/**');
project.addSources('Sources');

project.addLibrary('glm');

project.addParameter('-debug');

// HTML target
project.windowOptions.width = 640;
project.windowOptions.height = 480;

resolve(project);
