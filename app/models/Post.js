const mongoose = require('mongoose')

// START MONGOOSASTIC 
const mongoosastic = require('mongoosastic')
// END 

const PostSchema = new mongoose.Schema({
    Tag: String,
    Title: String,
    "Text": String,
    _id: Number
    })

// START
PostSchema.plugin(mongoosastic, {
    'host': 'localhost',
    'port': 9200
})

// PostSchema.methods.sync = function(){
//     const post = this

// }
// END

// NOTE: 'posts' 3rd arg only used bc database
// was seeded outside of express
mongoose.model('Post', PostSchema, 'posts') 

// Start
const Post = mongoose.model('Post', PostSchema)
Post.createMapping((err, mapping) => {
    console.log('mapping created')
})


// END

