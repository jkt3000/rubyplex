# RubyPlex Changelog

## Version 3.3.0 (2025-08-02)

### Major Features Added

**🚀 Advanced Query Filtering System**
- **16+ Query Parameters:** Added support for updatedAt, addedAt, rating, studio, genre, director, writer, actor, producer, resolution, audioCodec, videoCodec, container, and more
- **Operator Support:** Full support for `>=`, `<=`, `>`, `<`, `!=` operators
- **Complex Filtering:** Enable queries like `library.all('updatedAt>=' => '2025-08-01', 'rating>=' => '8.0', sort: 'addedAt:desc')`

**🔧 API Improvements**
- **Unified Parameters:** Simplified from `library.all(options: {})` to `library.all(param: value)`
- **Fresh Data:** Removed caching from `.total_count` and `.all` methods
- **Exact Path Matching:** Added `library_by_fullpath` method for precise path matching
- **Better Error Handling:** Enhanced with `Plex::Error` exceptions

### Technical Improvements

**⚡ Performance & Reliability**
- Manual URL construction to preserve query operators
- Consistent keyword argument usage (`**options`)
- Comprehensive test coverage (67 tests, 103 assertions)
- Fixed all parameter passing inconsistencies

**📚 Documentation Enhancements**
- Extensive advanced filtering examples in README
- Complete parameter reference with operators
- Sorting examples (ascending/descending)
- Pagination patterns and usage examples

### Backward Compatibility

✅ All existing functionality preserved  
✅ Existing `library_by_path` method unchanged  
✅ All original API methods still work

### Example Usage

```ruby
# Advanced filtering (new in 3.3.0)
recent_hits = library.all(
  'addedAt>=' => '2024-01-01',
  'rating>=' => '8.0',
  sort: 'rating:desc',
  limit: 10
)

# Exact path matching (new in 3.3.0)
library = server.library_by_fullpath("/volume1/Media/Movies")

# Simplified parameters (improved in 3.3.0)
page_two = library.all(page: 2, per_page: 25, sort: 'addedAt:desc')
```

### Breaking Changes

**None** - This release maintains full backward compatibility.

### Migration Guide

**From 3.2.x to 3.3.0:**

No migration required! All existing code continues to work. However, you can optionally modernize your code:

**Old style (still works):**
```ruby
library.all(options: {page: 1, per_page: 10})
```

**New style (recommended):**
```ruby
library.all(page: 1, per_page: 10)
```

### Detailed Changes

#### New Methods
- `Server#library_by_fullpath(path)` - Find library by exact path match

#### Enhanced Methods
- `Library#all(**options)` - Now supports advanced filtering with operators
- `Library#entries(**options)` - Unified parameter style
- `Library#newest(**options)` - Unified parameter style  
- `Library#recently_added(**options)` - Unified parameter style
- `Library#total_count` - Removed caching for fresh data

#### New Query Parameters
- **Content Filters:** `title`, `summary`, `rating`, `contentRating`, `studio`, `network`
- **People & Categories:** `genre`, `director`, `writer`, `actor`, `producer`
- **Technical Specs:** `resolution`, `audioCodec`, `videoCodec`, `container`
- **Timestamps:** `updatedAt`, `addedAt` (with operator support)
- **Pagination:** `limit`, `offset` (in addition to existing `page`/`per_page`)

#### New Operators
- `>=` (greater than or equal)
- `<=` (less than or equal)
- `>` (greater than)
- `<` (less than)
- `!=` (not equal)

#### Updated Dependencies
- Added `require 'cgi'` for proper URL encoding

### Credits

This release brings significant new functionality while maintaining full backward compatibility, making RubyPlex much more powerful for advanced Plex library management and querying.

---

## Previous Versions

### Version 3.2.2
- Enhanced configuration and Rails integration
- Improved logging with custom formatting
- Better error handling for YAML configuration loading

### Version 3.2.1
- Bug fixes and stability improvements

### Version 3.2.0
- Initial release with core Plex API functionality
- Basic library browsing and media access
- PIN-based authentication