cpjar = taskKey[Unit]("generate a project classpath Jar")
cpjar := {
  import java.util.jar.{Attributes, Manifest, JarOutputStream}
  import java.io.{File, FileOutputStream}
  import java.nio.file.{Files, Path, Paths}

  val projectDir =
    s"${baseDirectory.value}/.bloop/${name.value}/bloop-bsp-clients-classes"

    val cp = (dependencyClasspath in Test).value.files.map(_.toString)
    /* val cps = classDir + "/ " + testClassDir + "/ " + cp.mkString(" ") */
    val cps = cp.mkString(" ")
    val manifest = new Manifest
    manifest.getMainAttributes.put(Attributes.Name.MANIFEST_VERSION, "1.0")
    manifest.getMainAttributes.put(Attributes.Name.CLASS_PATH, cps)
    val jar = new JarOutputStream(new
        FileOutputStream(s"./${name.value}-classpath.jar"), manifest)
    jar.close
}]

Global / semanticdbEnabled := true
