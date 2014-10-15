# @author Nick Aversano
# graph coloring infection problem 
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

