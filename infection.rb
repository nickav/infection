#
# solution to graph coloring infection problem 
# users on a site should be on the same version,
# when pushing updates we want to keep most users on the same version
# 
# @author Nick Aversano
#

# starting with user, recursively infects (sets the version to version)
# for each coaches or is_coached_by relation
# @param: User user the starting user
# @param: int/String version the version to set
def total_infection (user, version)
  user.version = version
  for u in user.coaches
    if u.version != version
      total_infection u, version
    end
  end
  for u in user.is_coached_by
    if u.version != version
      total_infection u, version
    end
  end
end

# similar to total_infection, but attempts to come close to the limit
# without going over it. Tries to keep every user in a given class on
# the same version or at least nearly every user
# @param: User user the starting user
# @param: int/String version the version to set
def limited_infection (user, version, limit)
  q = []

  q.push user
  limit -= 1

  while !q.empty? 
    curr = q.pop
    #curr.version = version

    add = []
    for i in curr.coaches
      add.push i if i.version != version
    end

    curr.version = version unless add.length > limit

    if !add.empty? && add.length <= limit 
      q.concat add
      limit -= add.length
    end

    add = []
    for i in curr.is_coached_by
      add.push i if i.version != version
    end
    if !add.empty? && add.length <= limit 
      q.concat add
      limit -= add.length
    end
  end
end

