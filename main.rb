
# Input:

  @x = "Yulia".length - 1
  @y = "Ekaterina".length - 1
  @t1 = (@x + 100) % 17 # 13
  @t2 = (@y + 100) % 17 # 1
  @t3 = (@x * @y + 100) % 17 # 9
  @p = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 0.95, 0.99]
  @m = [1000, 10000]
  @edges = [[1,2], [1,9], [1,16], [2,3], [2,10], [3,4], [3,11], [4,5], [4,12], [5,6], [5,13], [6,7],
   [6,14], [7,8], [7,15], [8,9], [8,16], [9,10], [10,11], [11,12], [12,13],[13,14], [14,15], [15,16]]

def check_state(state_vector)
  v = [@t1]
  up_edges = state_vector.select{ |key, value| value == "up" }
  up_edges.length.times do
    up_edges.each do|key, _|
      if v.include?(key[0])
         v << key[1] unless v.include?(key[1])
      elsif v.include?(key[1])
         v << key[0] unless v.include?(key[0])
      end
    end
  end
  (v.include?(@t2) &&  v.include?(@t3)) ? true : false
end

def find_state_vector(p)
  edges_p = {}
  @edges.each do|e|
    edges_p[e] = rand()
  end
  edges_p.each do |edge, probability|
    edges_p[edge] =  (probability <= p) ? "up" : "down"
  end
  edges_p
end

@m.each do|amount|
  @p.each do|probability|
    r = 0
    amount.times do|_|
      r += 1 if check_state(find_state_vector(probability))
    end
    puts "M = #{amount.to_s},   p = #{probability.to_s},   R = " + (r.to_f/amount.to_f).to_s
  end
end




