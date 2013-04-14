module Labelize

  LABELS = {
    aws_register:       "Registra un account AWS",
    create_ami:         "Crea un'immagine server (AMI)",
    install_rdp_osx:    "Installa RDP (Mac)",
    connect_osx:        "Connettiti al server (Mac)",
    connect_win:        "Connettiti al server (Windows)",
    install_rdp_win:    "Installa RDP (Windows)",
    launch_ami:         "Lancia un server dall'immagine",
    terminate_instance: "Termina il server",
    install_software:   "Installa i software",
  }

  def label(name)
    LABELS[name.to_sym] || name
  end
end