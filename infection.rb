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
  q = Queue.new

  q.push user
  limit -= 1

  while !q.empty? 
    u = q.pop
    u.version = version

    break if user.coaches.length >= limit
    limit -= user.coaches.length
    for u in user.coaches
      q.push u
    end

    break if user.is_coached_by.length >= limit
    limit -= user.is_coached_by.length
    for u in user.is_coached_by 
      q.push u
    end
  end
end
