// Copyright 2016 Google Inc. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Foundation

let TEMPLATES = "Templates"

var s = ""
s += "// GENERATED: DO NOT EDIT\n"
s += "//\n"
s += "// This file contains base64 encodings of templates used for Swift GRPC code generation.\n"
s += "//\n"
s += "func loadTemplates() -> [String:String] {\n"
s += "  var templates : [String:String] = [:]\n"

let filenames = try FileManager.default.contentsOfDirectory(atPath:TEMPLATES)
for filename in filenames {
  if filename.hasSuffix(".swift") {
    let fileURL = URL(fileURLWithPath:TEMPLATES + "/" + filename)
    let filedata = try Data(contentsOf:fileURL)
    let encoding = filedata.base64EncodedString()
    s += "\n"
    s += "  templates[\"" + filename + "\"] = \"" + encoding + "\"\n"
  }
}

s += "  return templates\n"
s += "}\n"
print(s)
