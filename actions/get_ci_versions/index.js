const core = require('@actions/core');

const target_flutter_version = '1.22.1'
const target_flutter_channel = 'stable'

core.setOutput("flutter_version", target_flutter_version);
core.setOutput("flutter_channel", target_flutter_channel);
