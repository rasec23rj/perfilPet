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

  Map<String, dynamic> toMap(){
    return {

      'nome': nome,
      'imageURL': imageURL,
      'descricao': descricao,
      'idade':  idade,
      'sexo': sexo,
      'cor': cor,
      'bio':  bio

    };
  }
  Pet.fromMap(Map map) {
    id_pet= map['id_pet'];
    nome= map['nome'];
    imageURL= 'assets/images/pet.png';
    descricao= map['descricao'];
    idade= map['idade'];
    cor= map['cor'];
    sexo= map['sexo'];
    bio= map['bio'];
  }
}

