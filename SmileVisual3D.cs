﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Media.Media3D;
using System.Windows.Media;
using HelixToolkit.Wpf;
using Jitter.Collision.Shapes;
using Jitter.Dynamics;
using Jitter.Collision;
using Jitter.LinearMath;

namespace smileUp
{
    public class SmileVisual3D : ModelVisual3D
    {
        ModelVisual3D target;
        RigidBody body;

        public SmileVisual3D() 
        {
            
        }

        public SmileVisual3D(ModelVisual3D t)
        {
            this.target = t;

        }
        internal void createPlane()
        {
            if (target != null)
            {
                Rect3D r = target.Content.Bounds;
                GeometryModel3D cubeModel = GeometryGenerator.CreateCubeModel();
                cubeModel.Material = new DiffuseMaterial(new SolidColorBrush(Colors.Red));

                Transform3DGroup transformGroup = new Transform3DGroup();
                transformGroup.Children.Add(new ScaleTransform3D(r.X, r.Y, 5));
                transformGroup.Children.Add(new TranslateTransform3D(0, 0, 0));
                cubeModel.Transform = transformGroup;

                this.Content = cubeModel;
            }
        }

        public RigidBody getRigidBody()
        {
            Shape shape = new TriangleMeshShape(getOctree());
            if(body == null) body = new RigidBody(shape);
            else body.Shape = shape;
            
            body.Material.Restitution = 0.0f;            
            body.LinearVelocity = JVector.Zero;
            body.IsActive = false;
            //body.IsStatic = true;

            return body;
        }

        public Octree getOctree()
        {
            List<JVector> pos = new List<JVector>();
            List<TriangleVertexIndices> tris = new List<TriangleVertexIndices>();

            MeshGeometry3D mesh = GetMesh();
            for (int i = 0; i < mesh.TriangleIndices.Count; i += 3)
            {
                int i0 = mesh.TriangleIndices[i];
                int i1 = mesh.TriangleIndices[i + 1];
                int i2 = mesh.TriangleIndices[i + 2];
                var p0 = mesh.Positions[i0];
                var p1 = mesh.Positions[i1];
                var p2 = mesh.Positions[i2];

                pos.Add(new JVector((float)p0.X, (float)p0.Y, (float)p0.Z));
                pos.Add(new JVector((float)p1.X, (float)p1.Y, (float)p1.Z));
                pos.Add(new JVector((float)p2.X, (float)p2.Y, (float)p2.Z));

                tris.Add(new TriangleVertexIndices(i0, i1, i2));
            }
            Octree octree = new Octree(pos, tris);
            octree.BuildOctree();
            return octree;
        }

        public Point3D ToLocal(Point3D worldPoint)
        {
            var mat = Visual3DHelper.GetTransform(this);
            mat.Invert();
            var t = new MatrixTransform3D(mat);
            return t.Transform(worldPoint);
        }

        public Point3D ToWorld(Point3D point)
        {
            var mat = Visual3DHelper.GetTransform(this);
            var t = new MatrixTransform3D(mat);
            return t.Transform(point);
        }

        public Vector3D ToWorld(Vector3D vector)
        {
            var mat = Visual3DHelper.GetTransform(this);
            var t = new MatrixTransform3D(mat);
            return t.Transform(vector);
        }

        public void SetMesh(MeshGeometry3D mesh)
        {
            if (this.Content is Model3DGroup)
            {
                Model3DGroup g = (Model3DGroup)this.Content;
                GeometryModel3D gm = (GeometryModel3D)g.Children[0];

                Model3DGroup gr = new Model3DGroup();
                var m = new GeometryModel3D(mesh, gm.Material);
                gr.Children.Add(m);
                this.Content = gr;
            }
            else
            {
                GeometryModel3D gm = (GeometryModel3D)this.Content;
                var m = new GeometryModel3D(mesh, gm.Material);
                this.Content = m;
            }            
        }
        public  MeshGeometry3D GetMesh()
        {
            MeshGeometry3D mesh = null;
            if (this.Content is Model3DGroup)
            {
                Model3DGroup g = (Model3DGroup)this.Content;
                foreach (GeometryModel3D gm in g.Children)
                {
                    mesh = (MeshGeometry3D)gm.Geometry;
                }
            }
            else
            {
                GeometryModel3D gm = (GeometryModel3D)this.Content;
                mesh = (MeshGeometry3D)gm.Geometry;
            }
            return mesh;

        }
        public MeshGeometry3D ToWorldMesh()
        {
            MeshBuilder mb = new MeshBuilder(false, false);

            MeshGeometry3D mesh = GetMesh();

            if (mesh != null)
            {
                Point3DCollection ind = mesh.Positions;
                for (int i = 0; i < ind.Count; i++)
                {
                    var p0 = ToWorld(ind[i]);
                    mb.Positions.Add(p0);
                }

                for (int i = 0; i < mesh.TriangleIndices.Count; i++)
                {
                    mb.TriangleIndices.Add(mesh.TriangleIndices[i]);
                }

            }
            return mb.ToMesh();
        }

        public MeshGeometry3D ToLocalMesh(MeshGeometry3D  mesh)
        {
            MeshBuilder mb = new MeshBuilder(false, false);

            if (mesh != null)
            {
                Point3DCollection ind = mesh.Positions;
                for (int i = 0; i < ind.Count; i++)
                {
                    var p0 = ToLocal(ind[i]);
                    mb.Positions.Add(p0);
                }

                for (int i = 0; i < mesh.TriangleIndices.Count; i++)
                {
                    mb.TriangleIndices.Add(mesh.TriangleIndices[i]);
                }

            }
            return mb.ToMesh();
        }

        public void Cut(Point3D position, Vector3D normal)
        {
            MeshGeometry3D worldMesh = ToWorldMesh();
            var geo = MeshGeometryHelper.Cut(worldMesh, position, normal);
            MeshGeometry3D localMesh = ToLocalMesh(geo);

            if (this.Content is Model3DGroup)
            {
                Model3DGroup g = (Model3DGroup)this.Content;
                GeometryModel3D gm = (GeometryModel3D)g.Children[0];

                Model3DGroup gr = new Model3DGroup();
                var m = new GeometryModel3D(localMesh, gm.Material);
                gr.Children.Add(m);
                this.Content = gr;
            }
            else
            {
                GeometryModel3D gm = (GeometryModel3D)this.Content;
                var m = new GeometryModel3D(localMesh, gm.Material);
                this.Content = m;
            }            
        }
    }
}
