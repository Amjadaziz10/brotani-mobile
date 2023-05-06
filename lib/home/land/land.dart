// ignore_for_file: public_member_api_docs, sort_constructors_first
class LandCoba {
  String name;
  String location;
  String area;
  String plant;
  List<String> photo;

  LandCoba({
    required this.name,
    required this.location,
    required this.area,
    required this.plant,
    required this.photo,
  });
}

var landList = [
  LandCoba(
      name: 'Greenhouse Ludisar',
      location: 'Sunan Kalijaga',
      area: '50',
      plant: 'Melon',
      photo: [
        'https://images.unsplash.com/photo-1524486361537-8ad15938e1a3?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8Z3JlZW5ob3VzZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
        'https://images.unsplash.com/photo-1591754060004-f91c95f5cf05?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8Z3JlZW5ob3VzZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
        'https://images.unsplash.com/photo-1518994603110-1912b3272afd?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8Z3JlZW5ob3VzZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
        'https://images.unsplash.com/photo-1545151943-ae500b3c48a0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fGdyZWVuaG91c2V8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60'
      ]),
  LandCoba(
      name: 'Greenhouse Ludisar 2',
      location: 'Sunan Ampel',
      area: '20',
      plant: 'Anggur',
      photo: [
        'https://images.unsplash.com/photo-1591754060004-f91c95f5cf05?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8Z3JlZW5ob3VzZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
        'https://images.unsplash.com/photo-1524486361537-8ad15938e1a3?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8Z3JlZW5ob3VzZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
        'https://images.unsplash.com/photo-1518994603110-1912b3272afd?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8Z3JlZW5ob3VzZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
        'https://images.unsplash.com/photo-1545151943-ae500b3c48a0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fGdyZWVuaG91c2V8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60'
      ]),
  LandCoba(
      name: 'Greenhouse Ludisar 3',
      location: 'Bend. Tangga',
      area: '60',
      plant: 'Semangka',
      photo: [
        'https://images.unsplash.com/photo-1518994603110-1912b3272afd?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8Z3JlZW5ob3VzZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
        'https://images.unsplash.com/photo-1591754060004-f91c95f5cf05?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8Z3JlZW5ob3VzZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
        'https://images.unsplash.com/photo-1524486361537-8ad15938e1a3?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8Z3JlZW5ob3VzZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
        'https://images.unsplash.com/photo-1545151943-ae500b3c48a0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fGdyZWVuaG91c2V8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60'
      ]),
  LandCoba(
      name: 'Greenhouse Ludisar 4',
      location: 'Bend. Sutami',
      area: '65',
      plant: 'Manggis',
      photo: [
        'https://images.unsplash.com/photo-1545151943-ae500b3c48a0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fGdyZWVuaG91c2V8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
        'https://images.unsplash.com/photo-1518994603110-1912b3272afd?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8Z3JlZW5ob3VzZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
        'https://images.unsplash.com/photo-1591754060004-f91c95f5cf05?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8Z3JlZW5ob3VzZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
        'https://images.unsplash.com/photo-1524486361537-8ad15938e1a3?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8Z3JlZW5ob3VzZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
      ]),
  LandCoba(
      name: 'Greenhouse Ludisar 5',
      location: 'Ambarawa',
      area: '100',
      plant: 'Terong',
      photo: [
        'https://images.unsplash.com/uploads/1411901100260f56b39b9/ab70b250?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Z3JlZW5ob3VzZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
        'https://images.unsplash.com/photo-1545151943-ae500b3c48a0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fGdyZWVuaG91c2V8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
        'https://images.unsplash.com/photo-1518994603110-1912b3272afd?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8Z3JlZW5ob3VzZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
        'https://images.unsplash.com/photo-1591754060004-f91c95f5cf05?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8Z3JlZW5ob3VzZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
      ]),
];
