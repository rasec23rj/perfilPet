class Pet {
  String nome;
  String imageURL;
  String descricao;
  int idade;
  String sexo;
  String cor;
  String bio;
  int id_pet;

  Pet({
    this.nome,
    this.imageURL,
    this.descricao,
    this.idade,
    this.sexo,
    this.cor,
    this.bio,
    this.id_pet,
  });
}

var pets = [
  Pet(
      nome: 'Max',
      imageURL: 'assets/images/max.jpg',
      descricao: 'Um cachorro esperto',
      idade: 2,
      sexo: 'Macho',
      cor: 'Marrom e preto',
      bio: 'Sou um Max bem esperto',
      id_pet: 1),
  Pet(
      nome: 'Maria',
      imageURL: 'assets/images/maria.jpg',
      descricao: 'Um carinhosa',
      idade: 5,
      sexo: 'Femia',
      cor: 'Branca e bege',
      bio: 'Sou um Poodle bem carinhosa',
      id_pet: 2),
  Pet(
      nome: 'Darlene',
      imageURL: 'assets/images/lene.jpg',
      descricao: 'Um carinhosa',
      idade: 8,
      sexo: 'Femia',
      cor: 'Branca e bege',
      bio: 'Sou um Poodle bem carinhosa',
      id_pet: 3),
  Pet(
      nome: 'Clarice',
      imageURL: 'assets/images/clarice.jpg',
      descricao: 'Um carinhosa',
      idade: 1,
      sexo: 'Femia',
      cor: 'Branca ,bege e preto',
      bio: 'Sou um cadelinha bem carinhosa e brincanhona',
      id_pet: 4),
  Pet(
      nome: 'Preciosa',
      imageURL: 'assets/images/preci.jpg',
      descricao: 'Um carinhosa',
      idade: 8,
      sexo: 'Femia',
      cor: 'Branca ,bege ',
      bio: 'Sou um cadelinha bem carinhosa e brincanhona',
      id_pet: 4),
];
