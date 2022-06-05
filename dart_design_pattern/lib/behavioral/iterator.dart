part of '../main.dart';

abstract class JobBoard {
  JobRoleIterator createFetchJobByTermIterator(searchTerm);
}

abstract class JobRoleIterator {
  JobRole getNext();
  bool hasMore();
}

/// Glassdoor's classes
class Glassdoor implements JobBoard {
  @override
  createFetchJobByTermIterator(searchTerm) {
    return GlassdoorIterator(
        glassdoor: this, searchTerm: searchTerm, type: 'searchTerm');
  }
}

class GlassdoorIterator implements JobRoleIterator {
  final Glassdoor glassdoor;
  final String searchTerm;
  final String type;

  int currentPosition = 0;
  late List<JobRole> cache;

  GlassdoorIterator(
      {required this.glassdoor, required this.searchTerm, required this.type});

  _lazyInit() {
    /// Get jobs by [searchTerm] from remote [url]
    switch (type) {
      case 'searchTerm':
        cache = [
          JobRole(id: 1, jobTitle: 'C# developer'),
          JobRole(id: 2, jobTitle: 'Swift developer'),
        ];
        break;
    }
  }

  @override
  JobRole getNext() {
    if (hasMore()) {
      return cache[currentPosition++];
    }
    throw Exception('Invalid conditional');
  }

  @override
  bool hasMore() {
    _lazyInit();
    return currentPosition < cache.length;
  }
}

/// Indeed's classes
class Indeed implements JobBoard {
  @override
  createFetchJobByTermIterator(searchTerm) {
    return IndeedIterator(
        indeed: this, searchTerm: searchTerm, type: 'searchTerm');
  }
}

class IndeedIterator implements JobRoleIterator {
  final Indeed indeed;
  final String searchTerm;
  final String type;

  int currentPosition = 0;
  late List<JobRole> cache;

  IndeedIterator(
      {required this.indeed, required this.searchTerm, required this.type});

  _lazyInit() {
    /// Get jobs by [searchTerm] from remote [url]
    switch (type) {
      case 'searchTerm':
        cache = [
          JobRole(id: 1, jobTitle: 'Android developer'),
          JobRole(id: 2, jobTitle: 'Flutter developer'),
          JobRole(id: 3, jobTitle: 'Scala developer'),
        ];
        break;
    }
  }

  @override
  JobRole getNext() {
    if (hasMore()) {
      return cache[currentPosition++];
    }
    throw Exception('Invalid conditional');
  }

  @override
  bool hasMore() {
    _lazyInit();
    return currentPosition < cache.length;
  }
}

/// The crawler
class JobCrawler {
  fetch(JobRoleIterator iterator, String searchTerm) {
    while (iterator.hasMore()) {
      var jobRole = iterator.getNext();
      stdout
          .writeln('Found ${jobRole.jobTitle} when looking for "$searchTerm"');
    }
  }
}

class JobRole {
  int id;
  String jobTitle;
  JobRole({required this.id, required this.jobTitle});
}

class Iterator {
  static invoke() {
    stdout.writeln(
        '''The Iterator design pattern provides a way to access the elements 
of an aggregate object sequentially without exposing its underlying representation.
''');

    stdout.writeln('''Pros
- Single Responsibility Principle - separate classes handle client, collection and algo codes
- Open/Closed Principle - can implement new collections and iterators types without breaking the code
- Can iterate over the same collection - each object has its own state
- Can delay iteration and continue when needed
Cons
- Can be overkill for simple collections
- Can be less efficient than going through elements with specialized collections
\n''');

    stdout.writeln('Output of Job Board crawling process:\n');

    late JobBoard network;
    JobCrawler crawler;

    crawler = JobCrawler();

    fetchJobByTerm(network, searchTerm) {
      final iterator = network.createFetchJobByTermIterator(searchTerm);
      crawler.fetch(iterator, 'developer');
    }

    // execution #1 - fetching Glassdoor
    {
      network = Glassdoor();
      stdout.writeln('Fetching Glassdoor...');
      fetchJobByTerm(network, 'developer');
    }

    // execution #2 - fetching Indeed
    {
      network = Indeed();
      stdout.writeln('Fetching Indeed...');
      fetchJobByTerm(network, 'developer');
    }
  }
}


/// Other iterator implementation
// part of '../main.dart';

// abstract class SocialNetwork {
//   ProfileIterator createFriendsIterator(int profileId);
//   ProfileIterator createCoworkersIterator(int profileId);
// }

// abstract class ProfileIterator {
//   Profile getNext();
//   bool hasMore();
// }

// /// Facebook's classes
// class Facebook implements SocialNetwork {
//   @override
//   createFriendsIterator(profileId) {
//     return FacebookIterator(
//         facebook: this, profileId: profileId, type: 'friends');
//   }

//   @override
//   createCoworkersIterator(profileId) {
//     return FacebookIterator(
//         facebook: this, profileId: profileId, type: 'coworkers');
//   }
// }

// class FacebookIterator implements ProfileIterator {
//   final Facebook facebook;
//   final int profileId;
//   final String type;

//   int currentPosition = 0;
//   late List<Profile> cache;

//   FacebookIterator(
//       {required this.facebook, required this.profileId, required this.type});

//   _lazyInit() {
//     /// Get it from remote
//     switch (type) {
//       case 'friends':
//         cache = [
//           Profile(id: 1, email: 'elvis.presley@email.com'),
//           Profile(id: 2, email: 'michael.jackson@email.com'),
//         ];
//         break;
//       case 'coworkers':
//         cache = [];
//         break;
//     }
//   }

//   @override
//   Profile getNext() {
//     if (hasMore()) {
//       return cache[currentPosition++];
//     }
//     throw Exception('Invalid conditional');
//   }

//   @override
//   bool hasMore() {
//     _lazyInit();
//     return currentPosition < cache.length;
//   }
// }

// /// LinkedIn classes
// class LinkedIn implements SocialNetwork {
//   @override
//   createFriendsIterator(profileId) {
//     return LinkedInIterator(
//         linkedIn: this, profileId: profileId, type: 'friends');
//   }

//   @override
//   createCoworkersIterator(profileId) {
//     return LinkedInIterator(
//         linkedIn: this, profileId: profileId, type: 'coworkers');
//   }
// }

// class LinkedInIterator implements ProfileIterator {
//   final LinkedIn linkedIn;
//   final int profileId;
//   final String type;

//   int currentPosition = 0;
//   late List<Profile> cache;

//   LinkedInIterator(
//       {required this.linkedIn, required this.profileId, required this.type});

//   _lazyInit() {
//     /// Get it from remote
//     switch (type) {
//       case 'friends':
//         cache = [
//           Profile(id: 1, email: 'steve.jobs@email.com'),
//           Profile(id: 2, email: 'linux.torvalds@email.com'),
//         ];
//         break;
//       case 'coworkers':
//         cache = [
//           Profile(id: 1, email: 'melinda.french@email.com'),
//           Profile(id: 2, email: 'paul.allen@email.com'),
//         ];
//         break;
//     }
//   }

//   @override
//   Profile getNext() {
//     if (hasMore()) {
//       return cache[currentPosition++];
//     }
//     throw Exception('Invalid conditional');
//   }

//   @override
//   bool hasMore() {
//     _lazyInit();
//     return currentPosition < cache.length;
//   }
// }

// class SocialSpammer {
//   send(ProfileIterator iterator, String message) {
//     while (iterator.hasMore()) {
//       var profile = iterator.getNext();
//       stdout.writeln('Sending message "$message" to ${profile.email}');
//     }
//   }
// }

// class Profile {
//   int id;
//   String email;
//   Profile({required this.id, required this.email});
// }

// class Iterator {
//     late SocialNetwork network;
//     SocialSpammer spammer;

//     spammer = SocialSpammer();

//     sendSpamToFriends(network, profile) {
//       final iterator = network.createFriendsIterator(profile.id);
//       spammer.send(iterator, 'Very important message');
//     }

//     sendSpamToCoworkers(network, profile) {
//       final iterator = network.createCoworkersIterator(profile.id);
//       spammer.send(iterator, 'Very important message');
//     }

//     // test #1 - sending messages to george's facebook friends
//     {
//       network = Facebook();
//       stdout.writeln('Messaging George\'s friends');
//       final profile = Profile(id: 1, email: 'george.michael@email.com');
//       sendSpamToFriends(network, profile);
//     }

//     // test #2 - sending messages to bill's linkedin friends and coworkers
//     {
//       network = LinkedIn();
//       final profile = Profile(id: 1, email: 'bill.gates@email.com');

//       stdout.writeln('Messaging Bills\'s friends');
//       sendSpamToFriends(network, profile);

//       stdout.writeln('Messaging Bills\'s coworkers');
//       sendSpamToCoworkers(network, profile);
//     }
//   }
// }
