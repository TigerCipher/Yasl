//  ------------------------------------------------------------------------------
//
//  Interpreter
//     Copyright 2024 Matthew Rogers
//
//     Licensed under the Apache License, Version 2.0 (the "License");
//     you may not use this file except in compliance with the License.
//     You may obtain a copy of the License at
//
//         http://www.apache.org/licenses/LICENSE-2.0
//
//     Unless required by applicable law or agreed to in writing, software
//     distributed under the License is distributed on an "AS IS" BASIS,
//     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//     See the License for the specific language governing permissions and
//     limitations under the License.
//
//  ------------------------------------------------------------------------------

#ifndef INTERPRETER_BUILTIN_FUNCTIONS_H
#define INTERPRETER_BUILTIN_FUNCTIONS_H

#include <string>

namespace builtin_functions
{
void print(const std::string& format, int arg);
}

#endif //INTERPRETER_BUILTIN_FUNCTIONS_H
