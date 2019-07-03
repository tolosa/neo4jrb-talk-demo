# Demo script

Annotations with the code shown and explained during the Neo4j demo.

```ruby
# Find Keanu Reeves
keanu = Person.find_by name: 'Keanu Reeves'

# Movies with Keanu
keanu.acted_in

# Just the titles of the movies
# (explain pluck)
keanu.acted_in.pluck :title

# All actors who worked with Keanu
# (explain chained asociations)
# (explain that the final objetive is to get a query that lists actors who worked with Keanu in more than one movie)
keanu.acted_in.actors.pluck :name

# All actors without repeating
# (explain Cypher variables)
keanu.acted_in.actors(:a).pluck 'distinct(a.name)'

# Exclude Keanu himself from the list
# (explain where)
keanu.as(:k).acted_in.actors(:a).where('a <> k').pluck 'distinct(a.name)'

# All actors, with a count of movies shared with Keanu
keanu.as(:k).acted_in(:m).actors(:a).where('a <> k').pluck 'distinct(a.name), count(m)'

# Including the list of movies for each actor
# (explain collect, show that it can also return nodes)
keanu.as(:k).acted_in(:m).actors(:a).where('a <> k').pluck 'a.name, count(m), collect(m.title)'

# List only actors who worked with Keanu in more than one movie
# (explain with)
# (explain query_as)
# (explain query object DSL)
keanu.as(:k).acted_in(:m).actors.query_as(:a).where('a <> k').with('count(m) as count, a.name as name, collect(m.title) as titles').where('count > 1').pluck :count, :name, :titles

# Reviews of keanu's movies
# (explain why this returns users)
keanu.acted_in.reviews
# (explain each_rel)
keanu.acted_in.reviews.each_rel
keanu.acted_in(:m).reviews(:reviewer, :review).pluck 'm.title, reviewer.name, review.summary'

# All reviews from all movies, with rating
Movie.all(:m).reviews(:reviewer, :review).pluck 'm.title, reviewer.name, review.summary, review.rating'

# All users related to Paul
# (explain recursive associations)
user = Person.find_by name: 'Paul Blythe'
user.friends(rel_length: :any).pluck :name
```
