#include "auto_lists/phrase.hpp"

#include "auto_lists/core.hpp"

namespace auto_lists {

std::string phrase()
{
    return recursive_message() + " via ALL_CMAKELISTS_UNDER";
}

}  // namespace auto_lists
