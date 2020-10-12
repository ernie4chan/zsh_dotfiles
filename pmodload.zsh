# vim: ft=zsh

# Borrow Prezto pmodload function.
function pmodload {
	local -a pmodules
	local -a pmodule_dirs
	local -a locations
	local pmodule
	local pmodule_location
	local pfunction_glob='^([_.]*|prompt_*_setup|README*|*~)(-.N:t)'

	# Load in any additional directories and warn if they don't exist.
	zstyle -a ':zmodule:load' pmodule-dirs 'user_pmodule_dirs'
	for user_dir in "$user_pmodule_dirs[@]"; do
		if [[ ! -d "$user_dir" ]]; then
			echo "$0: Missing user module dir: $user_dir"
		fi
	done

	pmodule_dirs=("$ZDOTDIR/modules" "$ZDOTDIR/contrib" "$user_pmodule_dirs[@]")

	# $argv is overridden in the anonymous function.
	pmodules=("$argv[@]")

	# Load pmodules.
	for pmodule in "$pmodules[@]"; do
		if zstyle -t ":zmodule:$pmodule" loaded 'yes' 'no'; then
			continue
		else
			locations=(${pmodule_dirs:+${^pmodule_dirs}/$pmodule(-/FN)})
			if (( ${#locations} > 1 )); then
				if ! zstyle -t ':zmodule:load' pmodule-allow-overrides 'yes'; then
					print "$0: conflicting module locations: $locations"
					continue
				fi
			elif (( ${#locations} < 1 )); then
				print "$0: no such module: $pmodule"
				continue
			fi

			# Grab the full path to this module.
			pmodule_location=${locations[1]}

			# Add functions to $fpath.
			fpath=(${pmodule_location}/functions(-/FN) $fpath)

			function {
				local pfunction

				# Extended globbing is needed for listing autoloadable function directories.
				setopt LOCAL_OPTIONS EXTENDED_GLOB

				# Load functions.
				for pfunction in ${pmodule_location}/functions/$~pfunction_glob; do
					autoload -Uz "$pfunction"
				done
			}

			if [[ -s "${pmodule_location}/init.zsh" ]]; then
				source "${pmodule_location}/init.zsh"
			elif [[ -s "${pmodule_location}/${pmodule}.plugin.zsh" ]]; then
				source "${pmodule_location}/${pmodule}.plugin.zsh"
			fi

			if (( $? == 0 )); then
				zstyle ":zmodule:$pmodule" loaded 'yes'
			else
				# Remove the $fpath entry.
				fpath[(r)${pmodule_location}/functions]=()

				function {
					local pfunction

					# Extended globbing is needed for listing autoloadable function
					#  directories.
					setopt LOCAL_OPTIONS EXTENDED_GLOB

					# Unload Prezto functions.
					for pfunction in ${pmodule_location}/functions/$~pfunction_glob; do
						unfunction "$pfunction"
					done
				}

				zstyle ":zmodule:$pmodule" loaded 'no'
			fi
		fi
	done
}

# This finds the directory is installed to so plugin managers don't need
# to rely on dirty hacks to force prezto into a directory. Additionally, it
# needs to be done here because inside the pmodload function ${0:h} evaluates to
# the current directory of the shell rather than the prezto dir.
ZDOTDIR=${0:h}

# Load Zsh modules.
zstyle -a ':zmodule:load' zmodule 'zmodules'
for zmodule ("$zmodules[@]") zmodload "zsh/${(z)zmodule}"
unset zmodule{s,}

# Autoload Zsh functions.
zstyle -a ':zmodule:load' zfunction 'zfunctions'
for zfunction ("$zfunctions[@]") autoload -Uz "$zfunction"
unset zfunction{s,}

# Load modules.
zstyle -a ':zmodule:load' pmodule 'pmodules'
pmodload "$pmodules[@]"
unset pmodules
