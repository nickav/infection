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

=begin
def total_infection (user, version)
  q = Queue.new
  q.push user

  while !q.empty?
    u = q.pop
    u.version = version

    for u in user.coaches
      q.push u if u.version != version
    end
    for u in user.is_coached_by
      q.push u if u.version != version
    end
  end
end
=end

def limited_infection (user, version, limit)
  q = []

  q.push user
  limit -= 1

  while !q.empty? 
    u = q.pop
    #u.version = version

    count = 0
    for u in user.coaches
      count += 1 if u.version != version
    end
    u.version = version if count == 0 || count <= limit
    if count != 0 && count <= limit 
      q.concat user.coaches
      limit -= count
    end

    count = 0
    for u in user.is_coached_by
      count += 1 if u.version != version
    end
    if count != 0 && count <= limit 
      q.concat user.is_coached_by
      limit -= count
    end
  end
end

