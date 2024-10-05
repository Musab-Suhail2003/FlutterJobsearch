class job{
  final String created_date;
  final Map<String,dynamic> company; // name n logo.
  final Map<String,dynamic> location;
  final Map<String,dynamic> type; //fulltime or part time
  final Map<String,dynamic> workplace_type; //onsite vs off site
  final List<dynamic> job_role; //something supposed to get job role and title from
  final List<dynamic> type_of_sale;
  final List<String> timeAgo = [];

  job({
    required this.created_date,
    required this.company,
    required this.location,
    required this.type,
    required this.workplace_type,
    required this.job_role,
    required this.type_of_sale
  });

  factory job.fromJson(Map<String, dynamic> json) {
    var job0 = job(
      created_date: json['job']['created_date'],
      company: json['job']['company'],
      location: json['job']['location'],
      type: json['job']['type'],
      workplace_type: json['job']['workplace_type'],
      job_role: json['job']['icp_answers']['job-role'], 
      type_of_sale: json['job']['icp_answers']['type-of-sales']
      );

    

    return job0;
  }

}
