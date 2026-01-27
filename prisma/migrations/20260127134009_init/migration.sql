-- CreateEnum
CREATE TYPE "JenisKelamin" AS ENUM ('L', 'P');

-- CreateEnum
CREATE TYPE "StatusSurvei" AS ENUM ('PENDING', 'PROSES', 'FINISH');

-- CreateTable
CREATE TABLE "users" (
    "id" SERIAL NOT NULL,
    "nama" TEXT NOT NULL,
    "username" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "roleId" INTEGER NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "roles" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "roles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "pasien" (
    "id" SERIAL NOT NULL,
    "nama" TEXT,
    "jenis_kelamin" "JenisKelamin" NOT NULL,
    "pendidikan" TEXT NOT NULL,
    "pekerjaan" TEXT NOT NULL,
    "id_jenis_Layanan" INTEGER NOT NULL,
    "alamat" TEXT,
    "no_hp" TEXT NOT NULL,

    CONSTRAINT "pasien_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "JenisLayanan" (
    "id" SERIAL NOT NULL,
    "nama" TEXT NOT NULL,
    "aktif" BOOLEAN NOT NULL,

    CONSTRAINT "JenisLayanan_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "survei" (
    "id" SERIAL NOT NULL,
    "id_pasien" INTEGER NOT NULL,
    "status" "StatusSurvei" NOT NULL DEFAULT 'PENDING',
    "created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "survei_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "responden_pelayanan" (
    "id" SERIAL NOT NULL,
    "id_survei" INTEGER NOT NULL,
    "id_pertanyaan" INTEGER NOT NULL,
    "nilai" INTEGER NOT NULL,

    CONSTRAINT "responden_pelayanan_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "keluhan" (
    "id" SERIAL NOT NULL,
    "id_survei" INTEGER NOT NULL,
    "tanggal" DATE NOT NULL,
    "pukul" TIME NOT NULL,
    "masukan" TEXT NOT NULL,

    CONSTRAINT "keluhan_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "pertanyaan" (
    "id" SERIAL NOT NULL,
    "deskripsi" TEXT NOT NULL,
    "aktif" BOOLEAN NOT NULL,

    CONSTRAINT "pertanyaan_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "roles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pasien" ADD CONSTRAINT "pasien_id_jenis_Layanan_fkey" FOREIGN KEY ("id_jenis_Layanan") REFERENCES "JenisLayanan"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "survei" ADD CONSTRAINT "survei_id_pasien_fkey" FOREIGN KEY ("id_pasien") REFERENCES "pasien"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "responden_pelayanan" ADD CONSTRAINT "responden_pelayanan_id_survei_fkey" FOREIGN KEY ("id_survei") REFERENCES "survei"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "responden_pelayanan" ADD CONSTRAINT "responden_pelayanan_id_pertanyaan_fkey" FOREIGN KEY ("id_pertanyaan") REFERENCES "pertanyaan"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "keluhan" ADD CONSTRAINT "keluhan_id_survei_fkey" FOREIGN KEY ("id_survei") REFERENCES "survei"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
